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

namespace TPLaboratorio2
{
    public partial class FrmClientes2 : Form
    {
        public FrmClientes2()
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
            if (true)
            {

            }
            
            SqlConnection cnn = new SqlConnection(Properties.Resources.strConexion);

         
            SqlCommand cmd = new SqlCommand();
            DataTable tabla = new DataTable();

            cnn.Open();
            cmd.Connection = cnn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pa_clientes_mes";

            cmd.Parameters.AddWithValue("@anio",Convert.ToInt32(txtAnio.Text));

            tabla.Load(cmd.ExecuteReader());

            rpvClientes.LocalReport.DataSources.Clear();
            rpvClientes.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", tabla));

            rpvClientes.RefreshReport();

            cnn.Close();
        }
    }
}
