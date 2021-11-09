using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2
{
    public partial class FrmConsulta4 : Form
    {
        public FrmConsulta4()
        {
            InitializeComponent();
            txtCantidad.Text = "0";
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            List<Parametro> parametros = new List<Parametro>();
            parametros.Add(new Parametro("@min_cant_afiliados", Convert.ToInt32(txtCantidad.Text)));
            DataTable tabla = HelperDao.GetInstance().EjecutarSP("pa_clie_osocial", parametros);


            rpvClientes.LocalReport.DataSources.Clear();
            rpvClientes.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", tabla));

            rpvClientes.RefreshReport();

        }

        private void FrmConsulta4_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
        }
    }
}
