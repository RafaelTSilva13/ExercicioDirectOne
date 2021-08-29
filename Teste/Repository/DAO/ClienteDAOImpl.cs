using Domain;
using Microsoft.Data.SqlClient;
using Repository.Util;
using System;
using System.Collections.Generic;
using System.Data;

namespace Repository.DAO
{
    public class ClienteDAOImpl : BaseDAOImpl<Cliente>
    {
        public ClienteDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(Cliente entity)
        {
            using (DataTable dt = this.GetDatatable("spDeletaCliente @ID", new SqlParameter("ID", entity.Id)))
            {
                foreach (DataRow row in dt.Rows)
                {
                    var rModel = ParseToObject(row);
                    return rModel.Id > 0;
                }
            }
            return false;
        }

        public override Cliente GetByID(int id)
        {
            using (DataTable dt = this.GetDatatable("spObtemClientePorID @ID", new SqlParameter("ID", id)))
            {
                foreach (DataRow row in dt.Rows)
                {
                    return ParseToObject(row);
                }
            }

            return null;
        }

        public override List<Cliente> ListAll()
        {
            var list = new List<Cliente>();

            using (DataTable dt = this.GetDatatable("spListaCliente"))
            {
                foreach (DataRow row in dt.Rows)
                {
                    list.Add(ParseToObject(row));
                }
            }

            return list;
        }

        public override Cliente ParseToObject(DataRow row)
        {
            return new Cliente()
            {
                Id = row.GetValue("ID", default(int)),
                Nome = row.GetValue("Nome", string.Empty),
                CPF = row.GetValue("CPF", string.Empty),
                RG = row.GetValue("RG", string.Empty),
                DataNascimento = row.GetValue("DataNascimento", DateTime.Now),
                Ativo = row.GetValue("Ativo", default(bool))
            };
        }

        public override bool Save(Cliente entity)
        {
            using (DataTable dt = this.GetDatatable("spInsereCliente @Nome, @CPF, @RG, @DataNascimento, @Ativo", this.ParseToSqlParameter(entity)))
            {
                foreach (DataRow row in dt.Rows)
                {
                    var newEntity = ParseToObject(row);
                    entity.Id = newEntity.Id;
                    return newEntity.Id > 0;
                }
            }

            return false;
        }

        public override bool Update(Cliente entity)
        {
            using (DataTable dt = this.GetDatatable("spAtualizaCliente @ID, @Nome, @CPF, @RG, @DataNascimento, @Ativo", this.ParseToSqlParameter(entity)))
            {
                foreach (DataRow row in dt.Rows)
                {
                    var newEntity = ParseToObject(row);
                    return newEntity.Id > 0;
                }
            }

            return false;
        }

        private SqlParameter[] ParseToSqlParameter(Cliente entity)
        {
            return new SqlParameter[]
            {
                new SqlParameter("ID", (object)entity?.Id ?? DBNull.Value),
                new SqlParameter("Nome", (object)entity?.Nome ?? DBNull.Value),
                new SqlParameter("CPF", (object)entity?.CPF ?? DBNull.Value),
                new SqlParameter("RG", (object)entity?.RG ?? DBNull.Value),
                new SqlParameter("DataNascimento", (object)entity?.DataNascimento ?? DBNull.Value),
                new SqlParameter("Ativo", (object)entity?.Ativo ?? DBNull.Value)
            };
        }
    }
}
