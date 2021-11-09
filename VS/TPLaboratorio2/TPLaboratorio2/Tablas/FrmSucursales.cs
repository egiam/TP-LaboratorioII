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
    public partial class FrmSucursales : Form
    {
        public FrmSucursales()
        {
            InitializeComponent();
        }

        private void FrmSucursales_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select s.id_sucursal Codigo,  b.barrio, calle+', '+str(nro_calle) Direccion from sucursales s join barrios b on s.cod_barrio = b.cod_barrio";
            grdPlan.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
