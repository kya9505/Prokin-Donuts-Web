package com.donut.prokindonutsweb.inbound.dto;
import lombok.Getter;

@Getter
public enum StoredType {
    REFRIGERATED("냉장", 'R'),
    FROZEN("냉동", 'F'),
    ROOM_TEMPERATURE("상온", ' '); // 기본값

    private final String label;
    private final char codeSuffix;

    StoredType(String label, char codeSuffix) {
        this.label = label;
        this.codeSuffix = codeSuffix;
    }

    public static StoredType fromSectionCode(String sectionCode) {
        char lastChar = sectionCode.charAt(sectionCode.length() - 1);
        for (StoredType type : values()) {
            if (type.codeSuffix == lastChar) {
                return type;
            }
        }
        return ROOM_TEMPERATURE;
    }
}
