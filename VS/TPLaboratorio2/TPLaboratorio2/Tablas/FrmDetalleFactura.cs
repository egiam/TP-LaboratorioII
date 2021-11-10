using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmDetalleFactura : Form
    {
        public FrmDetalleFactura()
        {
            InitializeComponent();
        }

        private void FrmDetalleFactura_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select id_detalle_factura Codigo, id_factura 'Codigo de Factura', precio_unitario 'Precio por Unidad', Cantidad, Descuento, Reembolsado, s.nombre Suministro, df.precio_unitario * df.cantidad Importe from detalles_factura df join suministros s on df.codigo_barra = s.codigo_barra";
            grdPlan.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnCerrar_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
