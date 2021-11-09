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
using TPLaboratorio2.Tablas;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmObraSocial : Form
    {
        ConeccionEntreForms conex;
        public FrmObraSocial()
        {
            InitializeComponent();
            conex = new ConeccionEntreForms();
        }

        private void FrmObraSocial_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdOS);
            string select = "select * from obras_sociales";
            grdOS.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        //SqlConnection conexion = new SqlConnection(@"Data Source=localhost\SQLEXPRESS;Initial Catalog=Farmaceutica;Integrated Security=True");
        //SqlCommand comando = new SqlCommand();
        //DataTable tabla = new DataTable();

        //private DataTable consultarTabla(string select)
        //{
        //    conexion.Open();

        //    comando.Connection = conexion;
        //    comando.CommandType = CommandType.Text;
        //    comando.CommandText = select;
        //    DataTable tabla = new DataTable();
        //    tabla.Load(comando.ExecuteReader());

        //    conexion.Close();

        //    return tabla;
        //}
    }
}
