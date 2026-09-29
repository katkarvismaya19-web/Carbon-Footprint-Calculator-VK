package selenium;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.*;

import java.time.Duration;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CarbonFootprintSeleniumTest {

    private static WebDriver driver;
    private static final String BASE_URL =
            "http://localhost:8081/carbon-footprint-calculator/";

    @BeforeAll
    static void setup() {
        driver = new ChromeDriver();

        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
        driver.manage().window().maximize();
    }

    @AfterAll
    static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    @Test
    @Order(1)
    void dashboardLoads() {

        driver.get(BASE_URL);

        String page = driver.getPageSource();

        assertTrue(
            page.contains("Carbon Footprint") ||
            page.contains("Test User"),
            "Dashboard was not loaded"
        );
    }

    @Test
    @Order(2)
    void buildVersionVisible() {

        driver.get(BASE_URL);

        String page = driver.getPageSource();

        assertTrue(
            page.contains("Build 16"),
            "Expected CI/CD Build 16 marker not found"
        );
    }

    @Test
    @Order(3)
    void existingRecordVisible() {

        driver.get(BASE_URL);

        String page = driver.getPageSource();

        assertTrue(
            page.contains("Car Travel"),
            "Existing carbon record not found"
        );
    }

    @Test
    @Order(4)
    void carbonTotalVisible() {

        driver.get(BASE_URL);

        String page = driver.getPageSource();

        assertTrue(
            page.contains("1.9200"),
            "Expected carbon total was not found"
        );
    }

    @Test
    @Order(5)
    void activityOptionsVisible() {

        driver.get(BASE_URL);

        String page = driver.getPageSource();

        assertTrue(page.contains("Bus Travel"));
        assertTrue(page.contains("Train Travel"));
        assertTrue(page.contains("Electricity"));
        assertTrue(page.contains("LPG"));
        assertTrue(page.contains("Waste"));
    }
}
