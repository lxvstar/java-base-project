package com.sensetime.jv.controller;

import com.sensetime.jv.vo.response.BaseResponse;
import com.sensetime.jv.vo.response.module.ModuleVersionVo;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Module Info.
 *
 * @author LiuXing
 */
@RestController
@Slf4j
@RequestMapping("/api/v1")
public class ModuleInfo {
    @GetMapping("/module")
    public BaseResponse<ModuleVersionVo> getProjectVersions() {
        return BaseResponse.success(new ModuleVersionVo("1.0"));
    }
}
