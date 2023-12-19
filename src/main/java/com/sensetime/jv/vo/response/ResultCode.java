package com.sensetime.jv.vo.response;

/**
 * @program:
 * @description:
 * @author: LiuXing
 * @create: 2023-12-19
 */

public class ResultCode {
    private String code;
    private String msg;

    public ResultCode() {
    }

    public ResultCode(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return this.code;
    }

    public String getMsg() {
        return this.msg;
    }
}

