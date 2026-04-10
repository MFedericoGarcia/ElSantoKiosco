// ElSanto

// ElSanto es una app iOS desarrollada con SwiftUI y SwiftData para gestionar proveedores, productos, facturas y montos. Permite registrar proveedores, llevar el historial de precios de productos, y calcular totales por mes.

// Tecnologías
// - Swift 6 / Xcode 26
// - SwiftUI para la interfaz
// - SwiftData para persistencia

// Estructura principal
// - Views
//   - MainTabView: Navegación por pestañas 
//   - ContentView, ProveedoresView 
// - Models
//   - Proveedor: entidad de proveedor con facturas y productos relacionados
//   - Producto: entidad de producto con historial de precios
//   - Facturas: entidad para registrar montos y fechas de facturación
//   - PreciosHistoricos: entidad para registrar cambios de precio en el tiempo

// Modelos (resumen)
// Proveedor
// - id: UUID
// - name: String
// - boletaFacturacion: enum Boleta (blanco/negro)
// - montos: [Facturas]
// - productos: [Producto]
// - numeroContacto: String
// - Funciones:
//   - nuevaFactura(monto:fecha:)
//   - montosTotal(enMes:anio:) -> Double: suma montos por mes (y opcionalmente año)
//   - montosTotal(en:) -> Double: suma montos del mismo mes/año que una fecha dada
//   - save(): persiste cambios con SwiftData

// Producto
// - id: UUID
// - nombre: String
// - precioCosto: Double
// - precioVenta: Double
// - tipoProducto: enum TipoProducto (bebidas/varios/cigarrillos)
// - proveedores: Proveedor? (relación)
// - preciosHistoricos: [PreciosHistoricos]
// - Funciones:
//   - nuevoPrecio(_:fecha:): registra un nuevo precio y lo agrega al historial
//   - save(): persiste cambios

// Requisitos
// - iOS 17 o superior (recomendado)
// - Xcode 26.4

// Cómo compilar y ejecutar
// 1. Abrí el proyecto en Xcode.
// 2. Seleccioná un simulador o dispositivo.
// 3. Build & Run (⌘R).

// Persistencia (SwiftData)
// Las entidades marcadas con `@Model` (por ejemplo, `Proveedor` y `Producto`) se guardan en el `ModelContext`. Los métodos `save()` intentan persistir los cambios


// Cálculo de montos por mes
// Para obtener el total del mes actual:
// let totalMesActual = proveedor.montosTotal(en: Date())
// Para un mes específico:
// let totalAbril = proveedor.montosTotal(enMes: 4)
// let totalAbril2026 = proveedor.montosTotal(enMes: 4, anio: 2026)

// Roadmap / Ideas
// - Listado y filtro avanzado de proveedores y productos
// - Edición y visualización detallada de facturas
// - Gráficos de evolución de precios
// - Tests con Swift Testing
// - Widgets y Live Activities

// Contribución
// - Formateá el código con SwiftFormat/SwiftLint (si se agregan)
// - Preferí Swift Concurrency (async/await) cuando corresponda


