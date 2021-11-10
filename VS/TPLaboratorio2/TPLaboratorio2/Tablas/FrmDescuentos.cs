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
    public partial class FrmDescuentos : Form
    {
        public FrmDescuentos()
        {
            InitializeComponent();
        }

        private void FrmDescuentos_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select id_descuento Codigo, Tipo, Descuento, fecha_desde 'Desde', fecha_hasta Hasta, Localidad, p.Nombre+' - '+os.nombre 'Plan' " +
                            "from descuentos d join tipos_suministro ts on d.id_tipo_suministro = ts.id_tipo_suministro join localidades l on d.cod_localidad = l.cod_localidad join planes p on d.id_plan = p.id_plan join obras_sociales os on p.id_obra_social = os.id_obra_social";
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
