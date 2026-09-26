# Demo: Module 03 - Wireframing the order ticket in Figma

**Duration:** 25 minutes
**Prerequisite:** Figma open in a browser with a blank design file. The Week 3 user stories
for order placement (reproduced in `docs/03-WireframeBrief.docx`) and the Business
Requirements Specification (BRS) open in a second window.

## Part 1: start from the story, not the canvas (5 min)

1. Read US-01 (place a buy or sell order) and US-02 (see an indicative price) aloud.
2. Narration: before drawing anything, list what the user needs to see and do. Write the list
   on a Figma sticky note: instrument, side, quantity, limit price, indicative price, estimated
   cost, available cash, submit.
3. Point out that the list comes from the stories and from the Trade REST API contract
   (`shared/contracts/trade-api.yaml`, `PlaceOrderRequest`): the screen cannot ask for a field
   the API does not accept, and must collect every field it requires.

## Part 2: grey boxes only (12 min)

1. Add a Desktop frame (1440 by 1024). Name it `Order ticket - default`.
2. Draw the page header, a left column for the ticket and a right column for the price panel,
   using rectangles and plain text only. No colour, no icons, no logo.
3. Add the fields in the order the user fills them: instrument search, Buy/Sell toggle,
   quantity, limit price. Place available cash and estimated cost directly above the submit
   button.
4. Narration: grey is deliberate. Stakeholders comment on colour and fonts if they see them;
   at this fidelity the conversation stays on content, order and flow.
5. Duplicate the frame and name it `Order ticket - confirmation`. Draw the confirmation panel
   (summary of the order, Confirm and Back buttons).

## Part 3: make it clickable (5 min)

1. Switch to Prototype mode. Link Submit on the default frame to the confirmation frame, and
   Back to the default frame.
2. Press Present and click through the flow.
3. Narration: this is a low-fidelity prototype. It is enough to run a usability test in
   Module 08 and a demo in Module 14.

## Part 4: annotate (3 min)

1. Add numbered annotation markers beside the quantity field and the estimated cost.
2. Write the notes in a side panel: "Whole units only, minimum 1 (business rule 4)" and
   "Quantity multiplied by limit price; recalculates on every change".

## Key message

A wireframe is a thinking tool, not a drawing. Every element on it should trace to a user
story, a BRS requirement or a field in the API contract; anything that does not is a question
for the product owner.
