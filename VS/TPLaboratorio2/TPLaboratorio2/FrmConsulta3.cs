using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2
{
    public partial class FrmConsulta3 : Form
    {
        public FrmConsulta3()
        {
            InitializeComponent();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {

        }

        private void FrmConsulta3_Load(object sender, EventArgs e)
        {
            List<Parametro> parametros = new List<Parametro>();

            DataTable tabla = HelperDao.GetInstance().EjecutarSP("pa_consulta3", parametros);


            rpvClientes.LocalReport.DataSources.Clear();
            rpvClientes.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", tabla));

            rpvClientes.RefreshReport();

        }
    }
}
