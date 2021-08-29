using Domain;
using System.Collections.Generic;

namespace Repository
{
    public interface IBaseRepository<T>  where T : ModelBase
    {
        List<T> ListAll();

        T GetByID(int id);

        bool Save(T entity);

        bool Update(T entity);

        bool Delete(T entity);
    }
}