package com.carbon.model;

import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.junit.jupiter.api.Test;

public class CarbonRecordTest {

    @Test
    void testCarbonRecordSettersAndGetters() {

        CarbonRecord record = new CarbonRecord();

        record.setRecordId(1);
        record.setUserId(101);
        record.setActivityType("Electricity");
        record.setActivityValue(new BigDecimal("250.50"));
        record.setUnit("kWh");
        record.setEmissionFactor(new BigDecimal("0.82"));
        record.setCarbonEmission(new BigDecimal("205.41"));
        record.setRecordDate(LocalDate.of(2026, 8, 25));

        assertEquals(1, record.getRecordId());
        assertEquals(101, record.getUserId());
        assertEquals("Electricity", record.getActivityType());
        assertEquals(new BigDecimal("250.50"), record.getActivityValue());
        assertEquals("kWh", record.getUnit());
        assertEquals(new BigDecimal("0.82"), record.getEmissionFactor());
        assertEquals(new BigDecimal("205.41"), record.getCarbonEmission());
        assertEquals(LocalDate.of(2026, 8, 25), record.getRecordDate());
    }

    @Test
    void testDefaultCarbonRecord() {

        CarbonRecord record = new CarbonRecord();

        assertEquals(0, record.getRecordId());
        assertEquals(0, record.getUserId());
        assertNull(record.getActivityType());
        assertNull(record.getActivityValue());
        assertNull(record.getUnit());
        assertNull(record.getEmissionFactor());
        assertNull(record.getCarbonEmission());
        assertNull(record.getRecordDate());
    }
}
