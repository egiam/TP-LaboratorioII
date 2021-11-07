using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2
{
    public partial class FrmConsulta2 : Form
    {
        public FrmConsulta2()
        {
            InitializeComponent();
        }

        private void FrmClientes2_Load(object sender, EventArgs e)
        {

            this.rpvClientes.RefreshReport();
            txtAnio.Text= DateTime.Now.ToString("yyyy");

        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            if (txtAnio.Text=="")
            {
                MessageBox.Show("Debe ingresar un Año!", "Validación", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtAnio.Focus();
                return;
            }
            
            List<Parametro> parametros = new List<Parametro>();
            parametros.Add(new Parametro("@anio", txtAnio.Text));
            DataTable tabla=HelperDao.GetInstance().EjecutarSP("pa_clientes_mes", parametros);


            rpvClientes.LocalReport.DataSources.Clear();
            rpvClientes.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", tabla));

            rpvClientes.RefreshReport();

        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
