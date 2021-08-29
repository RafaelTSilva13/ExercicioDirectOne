using System;
using System.Data;

namespace Repository.Util
{
    public static class DataRowExtension
    {
        public static T GetValue<T>(this DataRow row, string columnName, T defaultValue)
        {
            try
            {
                if (row?.Table?.Columns?.Contains(columnName) ?? false)
                {
                    if (row[columnName] is T)
                    {
                        return (T)row[columnName];
                    }
                    else if (typeof(IConvertible).IsAssignableFrom((row[columnName].GetType())) && typeof(IConvertible).IsAssignableFrom(typeof(T)))
                    {
                        return (T)Convert.ChangeType(row[columnName], typeof(T));
                    }
                    else
                    {
                        return defaultValue;
                    }
                }
                else
                {
                    return defaultValue;
                }
            }
            catch
            {
                return defaultValue;
            }
        }
    }
}
