package selenium;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CarbonFootprintSeleniumTest {

    private static WebDriver driver;

    private static final String BASE_URL =
            System.getProperty(
                    "baseUrl",
                    "http://localhost:8081/carbon-footprint-calculator/"
            );

    private static final String DASHBOARD_URL =
            BASE_URL + "dashboard";

    private static final Duration WAIT_TIME =
            Duration.ofSeconds(10);

    @BeforeAll
    static void setup() {

        driver = new ChromeDriver();

        driver.manage().timeouts()
                .implicitlyWait(Duration.ofSeconds(5));

        driver.manage().window().maximize();
    }

    @AfterAll
    static void tearDown() {

        if (driver != null) {
            driver.quit();
        }
    }

    /*
     * Performs login ONCE.
     */
    private static void login() {

        driver.get(BASE_URL);

        WebDriverWait wait =
                new WebDriverWait(driver, WAIT_TIME);

        WebElement email =
                wait.until(
                        ExpectedConditions.visibilityOfElementLocated(
                                By.name("email")
                        )
                );

        WebElement password =
                driver.findElement(By.name("password"));

        email.clear();
        email.sendKeys("testuser@example.com");

        password.clear();
        password.sendKeys("test123");

        WebElement loginButton =
                driver.findElement(
                        By.cssSelector("button[type='submit']")
                );

        loginButton.click();

        /*
         * Wait for the dashboard page to load.
         */
        wait.until(
                ExpectedConditions.urlContains("/dashboard")
        );

        wait.until(
                ExpectedConditions.visibilityOfElementLocated(
                        By.xpath(
                                "//*[contains(text(),'Carbon Footprint Dashboard')]"
                        )
                )
        );
    }

    /*
     * Opens dashboard using the already authenticated session.
     */
    private static void openDashboard() {

        driver.get(DASHBOARD_URL);

        WebDriverWait wait =
                new WebDriverWait(driver, WAIT_TIME);

        wait.until(
                ExpectedConditions.visibilityOfElementLocated(
                        By.xpath(
                                "//*[contains(text(),'Carbon Footprint Dashboard')]"
                        )
                )
        );
    }

    /*
     * TEST 1
     * Verify that login works and dashboard loads.
     */
    @Test
    @Order(1)
    void loginAndDashboardLoads() {

        login();

        assertTrue(
                driver.getCurrentUrl().contains("/dashboard"),
                "Login did not redirect to dashboard"
        );

        String page =
                driver.getPageSource();

        assertTrue(
                page.contains("Carbon Footprint Dashboard"),
                "Carbon Footprint Dashboard was not loaded"
        );

        assertTrue(
                page.contains("Test User"),
                "Logged-in user name was not displayed"
        );
    }

    /*
     * TEST 2
     * Verify CI/CD build marker.
     */
    @Test
    @Order(2)
    void buildVersionVisible() {

        openDashboard();

        String page =
                driver.getPageSource();

        assertTrue(
                page.contains("Build 16"),
                "Expected CI/CD Build 16 marker not found"
        );
    }

    /*
     * TEST 3
     * Verify existing database record.
     */
    @Test
    @Order(3)
    void existingRecordVisible() {

        openDashboard();

        String page =
                driver.getPageSource();

        assertTrue(
                page.contains("Car Travel"),
                "Existing carbon record was not found"
        );
    }

    /*
     * TEST 4
     * Verify calculated carbon total.
     */
    @Test
    @Order(4)
    void carbonTotalVisible() {

        openDashboard();

        String page =
                driver.getPageSource();

        assertTrue(
                page.contains("1.9200"),
                "Expected carbon total 1.9200 was not found"
        );
    }

    /*
     * TEST 5
     * Verify all activity options.
     */
    @Test
    @Order(5)
    void activityOptionsVisible() {

        openDashboard();

        WebDriverWait wait =
                new WebDriverWait(driver, WAIT_TIME);

        WebElement activitySelect =
                wait.until(
                        ExpectedConditions.visibilityOfElementLocated(
                                By.name("activityType")
                        )
                );

        String optionsText =
                activitySelect.getText();

        assertAll(

                () -> assertTrue(
                        optionsText.contains("Car Travel"),
                        "Car Travel option not found"
                ),

                () -> assertTrue(
                        optionsText.contains("Bus Travel"),
                        "Bus Travel option not found"
                ),

                () -> assertTrue(
                        optionsText.contains("Train Travel"),
                        "Train Travel option not found"
                ),

                () -> assertTrue(
                        optionsText.contains("Electricity"),
                        "Electricity option not found"
                ),

                () -> assertTrue(
                        optionsText.contains("LPG"),
                        "LPG option not found"
                ),

                () -> assertTrue(
                        optionsText.contains("Waste"),
                        "Waste option not found"
                )
        );
    }
}