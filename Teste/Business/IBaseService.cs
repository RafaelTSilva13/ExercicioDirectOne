using System.Collections.Generic;

namespace Business
{
    public interface IBaseService<T>
    {
        List<T> ListAll();

        T GetByID(int id);

        bool Save(T entity);

        bool Update(T entity);

        bool Delete(T entity);
    }
}
