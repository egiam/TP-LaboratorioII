using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public class ConeccionEntreForms
    {
        SqlConnection conexion;
        SqlCommand comando;
        DataTable tabla;

        public ConeccionEntreForms()
        {
            conexion = new SqlConnection(@"Data Source=localhost\SQLEXPRESS;Initial Catalog=Farmaceutica;Integrated Security=True");
            comando = new SqlCommand();
            tabla = new DataTable();
        }

        public DataTable Coneccion(string select)
        {
            conexion.Open();

            comando.Connection = conexion;
            comando.CommandType = CommandType.Text;
            comando.CommandText = select;
            DataTable tabla = new DataTable();
            tabla.Load(comando.ExecuteReader());

            conexion.Close();

            return tabla;
        }

        public void AlternarColorGRD(DataGridView grilla)
        {
            grilla.BackgroundColor = Color.FromArgb(45, 66, 91);
            //grilla.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(160, 255, 255);
            //grilla.DefaultCellStyle.BackColor = Color.LightBlue;
            //grilla.ForeColor = Color.White;
            //grilla.ColumnHeadersDefaultCellStyle.BackColor = Color.DarkGray;

            grilla.AllowUserToAddRows = false;
            grilla.AllowUserToDeleteRows = false;
            grilla.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            grilla.EnableHeadersVisualStyles = false;
            grilla.ReadOnly = true;

            //grilla.RowHeadersVisible = false;
            //grilla.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            grilla.RowsDefaultCellStyle.BackColor = Color.FromArgb(45, 66, 91);
            grilla.RowsDefaultCellStyle.ForeColor = Color.White;
            grilla.RowsDefaultCellStyle.SelectionBackColor = Color.SteelBlue;
            grilla.RowsDefaultCellStyle.SelectionForeColor = Color.White;
            grilla.GridColor = Color.SteelBlue;

            grilla.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(3, 101, 205);
            grilla.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            grilla.ColumnHeadersBorderStyle = DataGridViewHeaderBorderStyle.None;
            grilla.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            grilla.ColumnHeadersHeight = 25;

            grilla.RowHeadersDefaultCellStyle.BackColor = Color.FromArgb(45, 66, 91);
            grilla.RowHeadersDefaultCellStyle.ForeColor = Color.White;
            grilla.RowHeadersDefaultCellStyle.SelectionBackColor = Color.SteelBlue;
            grilla.RowHeadersBorderStyle = DataGridViewHeaderBorderStyle.Single;

            grilla.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            grilla.CellBorderStyle = DataGridViewCellBorderStyle.Single;
            grilla.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            grilla.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;
        }

    }
}
