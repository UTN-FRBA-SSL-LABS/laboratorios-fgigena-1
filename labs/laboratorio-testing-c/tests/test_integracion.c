#include <stdio.h>
#include "../src/carrito.h"
#include "minunit/minunit.h"

/*
 * Tests de integracion: verifican que las funciones trabajan bien
 * en combinacion, no de forma aislada.
 */

/* ═══════════════════════════════════════════════════════════════════════════
 *  PARTE D — test_compra_con_descuento
 * ═══════════════════════════════════════════════════════════════════════════ */

void test_compra_con_descuento(void) {
    printf("\n[compra con descuento]\n");
    Carrito c;
    carrito_init(&c);
    Producto pan   = {"Pan",   200, 3};  /* 200 x 3 = 600 */
    Producto leche = {"Leche", 350, 2};  /* 350 x 2 = 700 */
    carrito_agregar(&c, pan);
    carrito_agregar(&c, leche);
    /* Total esperado: 600 + 700 = 1300 */
    ASSERT_IGUAL(1300, carrito_total(&c));
    /* Con 10% de descuento: 1300 - 130 = 1170 */
    ASSERT_IGUAL(1170, carrito_descuento(carrito_total(&c), 10));
}

/* ═══════════════════════════════════════════════════════════════════════════
 *  PARTE E — test_agregar_hasta_llenar
 * ═══════════════════════════════════════════════════════════════════════════ */

void test_agregar_hasta_llenar(void) {
    printf("\n[agregar hasta llenar el carrito]\n");
    Carrito c;
    carrito_init(&c);
    Producto p = {"Queso", 1500, 1};
    carrito_agregar(&c, p);
    carrito_agregar(&c, p);
    carrito_agregar(&c, p);
    carrito_agregar(&c, p);
    /* 1. El conteo debe ser MAX_ITEMS */
    ASSERT_IGUAL(MAX_ITEMS, carrito_contar(&c));
    /* 2. El 5to intento devuelve 0 */
    ASSERT_IGUAL(0, carrito_agregar(&c, p));
    /* 3. El conteo sigue siendo MAX_ITEMS */
    ASSERT_IGUAL(MAX_ITEMS, carrito_contar(&c));
}

int main(void) {
    printf("=== Tests de integracion ===");
    test_compra_con_descuento();
    test_agregar_hasta_llenar();
    RESUMEN();
    return EXIT_CODE();
}