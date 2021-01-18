package com.sbj.urs.model.domain;

import lombok.Data;

@Data
public class TableMap {
   private int tablemap_id;
   private int store_id;   
   private String map_index;
   private String unavailable;
   private String is_first;
}