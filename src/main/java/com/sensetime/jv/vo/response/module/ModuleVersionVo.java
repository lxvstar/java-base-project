package com.sensetime.jv.vo.response.module;

import lombok.Data;

/**
 * @Description:
 * @Author: Dirk
 * @Date: 2023/2/15
 */

@Data
public class ModuleVersionVo {
    String version;
    public ModuleVersionVo(String version){
        this.version = version;
    }
}
