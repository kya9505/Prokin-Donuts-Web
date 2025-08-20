package com.donut.prokindonutsweb.outbound.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

// OutboundCompletionResult.java
@Data
@AllArgsConstructor
@Builder
public class OutboundCompletionResult {
    private int successCount;
    private int failCount;
}
