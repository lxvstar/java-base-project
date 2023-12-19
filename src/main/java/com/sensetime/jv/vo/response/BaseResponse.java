package com.sensetime.jv.vo.response;

import com.sensetime.jv.constant.BizConstant;
import com.sensetime.jv.exception.BaseException;
import lombok.Data;

@Data
public class BaseResponse<T> {
    private static final long serialVersionUID = 1L;
    private String code;
    private String msg;
    private T data;

    public BaseResponse() {
    }

    public BaseResponse(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public BaseResponse(String code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public BaseResponse(ResultCode resultCode) {
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), "");
    }

    public BaseResponse(ResultCode resultCode, String message) {
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), message);
    }

    public static <T> BaseResponse<T> success(T data) {
        BaseResponse<T> response = new BaseResponse();
        response.code = BizConstant.SUCCESS.getCode();
        response.msg = BizConstant.SUCCESS.getMsg();
        response.data = data;
        return response;
    }

    public static <T> BaseResponse<T> success() {
        BaseResponse<T> response = new BaseResponse();
        response.code = BizConstant.SUCCESS.getCode();
        response.msg = BizConstant.SUCCESS.getMsg();
        response.data = null;
        return response;
    }

    public static <T> BaseResponse<T> fail(ResultCode resultCode) {
        BaseResponse<T> response = new BaseResponse<T>();
        response.code = resultCode.getCode();
        response.msg = String.format(resultCode.getMsg(), "");
        return response;
    }

    public static BaseResponse fail(String msg) {
        BaseResponse response = new BaseResponse();
        response.code = "-1";
        response.msg = msg;
        return response;
    }

    public static <T> BaseResponse<T> fail(String code, String msg) {
        BaseResponse<T> response = new BaseResponse<T>();
        response.code = code;
        response.msg = msg;
        return response;
    }

    public static BaseResponse fail(BaseException e) {
        BaseResponse response = new BaseResponse();
        response.code = e.getCode();
        response.msg = e.getMsg();
        return response;
    }

    public static <T> BaseResponse<T> fail(String code, String msg, T data) {
        BaseResponse response = new BaseResponse();
        response.code = code;
        response.msg = msg;
        response.data = data;
        return response;
    }

    public static <T> BaseResponse<T> fail(ResultCode resultCode, String message) {
        BaseResponse response = new BaseResponse();
        response.code = resultCode.getCode();
        response.msg = String.format(resultCode.getMsg(), message);
        return response;
    }

    public static BaseResponse fail(ResultCode resultCode, String... message) {
        BaseResponse response = new BaseResponse();
        response.code = resultCode.getCode();
        response.msg = String.format(resultCode.getMsg(), message);
        return response;
    }

    public static BaseResponse fail(BaseResponse baseResponse) {
        BaseResponse response = new BaseResponse();
        response.code = baseResponse.getCode();
        response.msg = baseResponse.getMsg();
        return response;
    }

    public boolean isSuccess() {
        return BizConstant.SUCCESS.getCode().equals(this.code);
    }
}

