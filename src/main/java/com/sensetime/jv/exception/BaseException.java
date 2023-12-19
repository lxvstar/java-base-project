package com.sensetime.jv.exception;

import com.sensetime.jv.vo.response.ResultCode;
import org.apache.commons.lang.StringUtils;
import org.springframework.util.ObjectUtils;

/**
 * @program:
 * @description:
 * @author: LiuXing
 * @create: 2023-12-19
 */
public class BaseException extends RuntimeException {
    private String code;
    private String msg;

    public BaseException(ResultCode resultCode) {
        super(resultCode.getMsg());
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), "");
    }

    public BaseException(ResultCode resultCode, String message) {
        super(resultCode.getMsg());
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), message);
    }

    public BaseException(ResultCode resultCode, Throwable throwable) {
        super(throwable);
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), "");
    }

    public BaseException(ResultCode resultCode, String message, Throwable throwable) {
        super(throwable);
        this.code = resultCode.getCode();
        this.msg = String.format(resultCode.getMsg(), message);
    }

    public BaseException(String code, String message, Throwable throwable) {
        super(throwable);
        this.code = code;
        this.msg = message;
    }

    public BaseException(String code, String message) {
        super(message);
        this.code = code;
        this.msg = message;
    }

    public BaseException(ResultCode resultCode, Object... args) {
        super(resultCode.getMsg());
        this.code = resultCode.getCode();
        this.msg = format(resultCode.getMsg(), args);
    }

    private static String format(String pattern, Object[] args) {
        if (StringUtils.isNotEmpty(pattern) && !ObjectUtils.isEmpty(args)) {
            return String.format(pattern, args);
        }
        return pattern;
    }

    @Override
    public String toString() {
        return "BaseException{code='" + this.code + '\'' + ", msg='" + this.msg + '\'' + '}';
    }

    public String getCode() {
        return this.code;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public void setMsg(final String msg) {
        this.msg = msg;
    }

    @Override
    public String getMessage() {
        return getMsg();
    }
}
