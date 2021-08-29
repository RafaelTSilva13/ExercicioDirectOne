using Domain;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Repository.DAO
{
    public abstract class BaseDAOImpl<T> : IBaseRepository<T> where T : ModelBase
    {
        private readonly DatabaseOptions databaseOptions;

        public BaseDAOImpl(DatabaseOptions databaseOptions)
        {
            this.databaseOptions = databaseOptions;
        }

        public abstract bool Delete(T entity);

        public abstract T GetByID(int id);

        public abstract List<T> ListAll();

        public abstract bool Save(T entity);

        public abstract bool Update(T entity);

        public abstract T ParseToObject(DataRow row);

        protected DataTable GetDatatable(string query, params SqlParameter[] parameters)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(this.databaseOptions.ConnectionString))
            {
                sqlConnection.Open();
                using (SqlCommand sqlCommand = new SqlCommand(query, sqlConnection))
                {
                    if (parameters != null && parameters.Any())
                    {
                        sqlCommand.Parameters.AddRange(parameters);
                    }

                    sqlCommand.CommandTimeout = 300;
                    sqlCommand.CommandType = CommandType.Text;

                    using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                    {
                        sqlDataAdapter.Fill(dataTable);
                    }
                }
            }

            return dataTable;
        }
    }
}
