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
    public partial class FrmRecetas : Form
    {
        public FrmRecetas()
        {
            InitializeComponent();
        }

        private void FrmRecetas_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select id_receta Codigo, m.apellido+', '+m.nombre Medico, c.apellido+', '+c.nombre Cliente, Diagnostico, Fecha " +
                            "from recetas r join medicos m on r.id_medico = m.id_medico join clientes c on r.id_cliente = c.id_cliente";
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
