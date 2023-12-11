﻿using System;
using System.Collections.Generic;

namespace Entities.Entities
{
    public partial class Carrito
    {
        public int CarritoId { get; set; }
        public int UsuarioId { get; set; }
        public int ProductoId { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Subtotal { get; set; }

        public virtual Producto Producto { get; set; } = null!;
        public virtual Usuario Usuario { get; set; } = null!;
    }
}
