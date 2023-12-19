package com.sensetime.jv.constant;

import com.sensetime.jv.vo.response.ResultCode;

/**
 * @program:
 * @description:
 * @author: LiuXing
 * @create: 2023-12-19
 */
public class BizConstant {
    public static String SPLIT="-";
    public static String SPLIT_UNDERLINE="_";
    public static String SPLIT1="-";
    public static String SPOT_REG="\\.";
    public static String SPOT=".";
    public static String EQUAL_SIGN="=";
    public static final String COMMA = ",";

    public static final ResultCode SUCCESS = new ResultCode("0", "Success");
    public static final ResultCode PARAM_ERROR = new ResultCode("400", "Param invalid");
    public static final ResultCode PARAM_ERROR_MSG = new ResultCode("400", "Param invalid, %s");
    public static final ResultCode UNAUTHORIZED = new ResultCode("401", "Unauthorized, %s");
    public static final ResultCode CUSTOMER_ID_URL_ERROR = new ResultCode("400", "Customer id invalid");
    public static final ResultCode UPLOAD_FILE_ERROR = new ResultCode("500", "Upload file filed");
    public static final ResultCode MEDIA_TYPE_ERROR = new ResultCode("400", "Identifier not match. Please upload again, current identifier: %s");
    public static final ResultCode MEDIA_TYPE_SUFFIX_ERROR = new ResultCode("400", "The current type [%s] does not support files in the [%s] format");
    public static final ResultCode MD5_TYPE_ERROR = new ResultCode("400", "Media type invalid");
    public static final ResultCode SERVER_ERROR = new ResultCode("500", "Server error");
    public static final ResultCode SIGN_EMPTY_ERROR = new ResultCode("501", "Sign is empty");
    public static final ResultCode SIGN_INVALID_ERROR = new ResultCode("502", "Sign valid fail");
    public static final ResultCode RESOURCE_NOT_FOUND = new ResultCode("404", "%s '%s' not found");

    public static final ResultCode DEVICE_LIMIT_EXCEEDED_ERROR = new ResultCode("429", "Device limit exceeded");
    public static final ResultCode MINIO_URI_NOT_FOUND = new ResultCode("430", "Invalid storage object uri %s");
    public static final ResultCode PARAMS_EMPTY_ERROR = new ResultCode("431", "The %s parameter is empty");
    public static final ResultCode PARAMS_CHECK_ERROR = new ResultCode("432", "%s Parameter validation error");

    public static final ResultCode SERVICE_NOT_AVAILABLE = new ResultCode("1401", "Service not available");

}
