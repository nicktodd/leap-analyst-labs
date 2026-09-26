package com.leap.trading.domain;

// The error catalogue from trade-api.yaml (ErrorResponse.errorCode).
public enum ErrorCode {
    ACC_404(404, "ACC-404"),   // account not found
    ACC_403(403, "ACC-403"),   // account not active, or not reachable with this token
    INS_404(404, "INS-404"),   // instrument not found or not tradable
    ORD_400(400, "ORD-400"),   // insufficient funds
    ORD_409(409, "ORD-409"),   // insufficient holdings, duplicate order, not cancellable
    VAL_422(422, "VAL-422"),   // invalid input
    AUTH_401(401, "AUTH-401"); // unauthorised or invalid token

    private final int httpStatus;
    private final String code;

    ErrorCode(int httpStatus, String code) {
        this.httpStatus = httpStatus;
        this.code = code;
    }

    public int getHttpStatus() { return httpStatus; }
    public String getCode() { return code; }
}
