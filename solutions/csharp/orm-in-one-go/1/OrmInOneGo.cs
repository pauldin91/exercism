public class Orm
{
    private Database database;

    public Orm(Database database)
    {
        this.database = database;
    }

    public void Write(string data)
    {
        try
        {
            database.BeginTransaction();
            database.Write(data);
            database.EndTransaction();
        }
        finally
        {
            database.Dispose();
        }
    }

    public bool WriteSafely(string data)
    {
        bool result = false;

        if (data.StartsWith("bad", StringComparison.OrdinalIgnoreCase))
            result = false;
        else
        {
            database.BeginTransaction();
            database.Write(data);
            database.EndTransaction();
            result = true;
        }

        database.Dispose();

        return result;
    }
}