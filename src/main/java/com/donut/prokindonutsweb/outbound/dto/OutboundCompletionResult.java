package com.donut.prokindonutsweb.outbound.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

// OutboundCompletionResult.java
@Data
@AllArgsConstructor
public class OutboundCompletionResult {
    private int successCount;
    private int failCount;
}
