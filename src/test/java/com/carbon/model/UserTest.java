package com.carbon.model;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

public class UserTest {

    @Test
    void testDefaultUser() {

        User user = new User();

        assertEquals(0, user.getUserId());
        assertNull(user.getName());
        assertNull(user.getEmail());
        assertNull(user.getPassword());
        assertNull(user.getRole());
    }

    @Test
    void testUserConstructor() {

        User user = new User(
            1,
            "Vismaya",
            "vismaya@example.com",
            "password123",
            "admin"
        );

        assertEquals(1, user.getUserId());
        assertEquals("Vismaya", user.getName());
        assertEquals("vismaya@example.com", user.getEmail());
        assertEquals("password123", user.getPassword());
        assertEquals("admin", user.getRole());
    }

    @Test
    void testUserSettersAndGetters() {

        User user = new User();

        user.setUserId(10);
        user.setName("Test User");
        user.setEmail("test@example.com");
        user.setPassword("test123");
        user.setRole("user");

        assertEquals(10, user.getUserId());
        assertEquals("Test User", user.getName());
        assertEquals("test@example.com", user.getEmail());
        assertEquals("test123", user.getPassword());
        assertEquals("user", user.getRole());
    }
}
