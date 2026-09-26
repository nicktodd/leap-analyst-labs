package com.leap.trading.service;

// Records an order after it passes validation (BR-05, BR-06).
public class OrderService {

    private final OrderValidator validator;
    private final OrderRepository orders;
    private final OrderPublisher publisher;

    public OrderService(OrderValidator validator, OrderRepository orders, OrderPublisher publisher) {
        this.validator = validator;
        this.orders = orders;
        this.publisher = publisher;
    }

    public OrderResponse placeOrder(PlaceOrderRequest request) {
        try {
            validator.validate(request);                 // rules 1 to 7
        } catch (TradingException e) {
            orders.saveRejected(request, e.getCode());   // rejected orders are recorded too
            throw e;
        }
        Order order = orders.saveNew(request);           // rule 8: unique idempotency_key
        publisher.publishOrderPlaced(order);             // after the commit, to the orders topic
        return OrderResponse.accepted(order);
    }
}
