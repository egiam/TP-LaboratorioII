using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TPLaboratorio2.Dao
{
    class HelperDao
    {
        private string ConnectionString = Properties.Resources.strConexion;
        private static HelperDao instance;
        private HelperDao()
        {
            
        }

        public static HelperDao GetInstance()
        {

            if (instance == null)
            {
                instance = new HelperDao();
            }
            return instance;
        }

        public DataTable EjecutarSP(string nombreSP, List<Parametro> parametros)
        {
            SqlConnection cnn = new SqlConnection(ConnectionString);

            SqlCommand cmd = new SqlCommand(nombreSP, cnn);
            DataTable tabla = new DataTable();

            cnn.Open();
            cmd.CommandType = CommandType.StoredProcedure;

            foreach (Parametro p in parametros)
            {
                if (p.Valor == null)
                    cmd.Parameters.AddWithValue(p.Nombre, DBNull.Value);
                else
                    cmd.Parameters.AddWithValue(p.Nombre, p.Valor.ToString());
            }
            
            tabla.Load(cmd.ExecuteReader());
            cnn.Close();

            return tabla;
            
        }
    }
}
