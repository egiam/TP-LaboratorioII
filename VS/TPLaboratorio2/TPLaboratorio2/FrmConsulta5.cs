using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2
{
    public partial class FrmConsulta5 : Form
    {
        public FrmConsulta5()
        {
            InitializeComponent();
        }

        private void FrmConsulta5_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);

            List<Parametro> parametros = new List<Parametro>();
            DataTable tabla = HelperDao.GetInstance().EjecutarSP("pa_mes_pas", parametros);


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
