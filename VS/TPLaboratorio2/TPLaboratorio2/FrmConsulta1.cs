using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2
{
    public partial class FrmConsulta1 : Form
    {
        public FrmConsulta1()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            //if (txtAnio.Text == "")
            //{
            //    MessageBox.Show("Debe ingresar un Año!", "Validación", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    txtAnio.Focus();
            //    return;
            //}

            List<Parametro> parametros = new List<Parametro>();
            parametros.Add(new Parametro("@fecha_desde", dtpDesde.Value.ToString()));
            parametros.Add(new Parametro("@fecha_hasta", dtpHasta.Value.ToString()));
            parametros.Add(new Parametro("@tipo", txtTipoSuministro.Text));
            DataTable tabla = HelperDao.GetInstance().EjecutarSP("pa_total_facturacion", parametros);

            grdResultado.DataSource = tabla;
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
