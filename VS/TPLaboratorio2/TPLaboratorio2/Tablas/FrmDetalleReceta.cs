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
    public partial class FrmDetalleReceta : Form
    {
        public FrmDetalleReceta()
        {
            InitializeComponent();
        }

        private void FrmDetalleReceta_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select id_detalle_receta Codigo, id_receta 'Codigo de Receta', s.nombre Suministro, Cantidad, cod_aprobacion 'Codigo de Aprobacion' "+
                            "from detalles_receta dr join suministros s on dr.codigo_barra = s.codigo_barra";
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
