#define RCC_AHB1ENR (*(volatile unsigned int*)0x40023830)
#define GPIOA_MODER (*(volatile unsigned int*)0x40020000)
#define GPIOA_ODR   (*(volatile unsigned int*)0x40020014)

void Reset_Handler(void);
int main(void);

__attribute__((section(".isr_vector")))
void (* const vectors[])(void) = {
    (void (*)(void))0x20018000, // STACK TOP (adjust for your MCU)
    Reset_Handler
};

void Reset_Handler(void)
{
    main();
    while (1);
}

void delay(volatile unsigned int d)
{
    while (d--) __asm__("nop");
}

int main(void)
{
    RCC_AHB1ENR |= (1 << 0);          // GPIOA clock
    GPIOA_MODER &= ~(3 << (5 * 2));
    GPIOA_MODER |=  (1 << (5 * 2));   // PA5 output

    while (1) {
        GPIOA_ODR ^= (1 << 5);        // LD2
        delay(80000);
    }
}
