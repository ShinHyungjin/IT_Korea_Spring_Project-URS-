package com.sbj.urs.model.domain;

import lombok.Data;

@Data
public class Amount {
 
    private Integer total, tax_free, vat, point, discount;
}