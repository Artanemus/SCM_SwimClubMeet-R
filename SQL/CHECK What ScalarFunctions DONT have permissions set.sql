USE SwimClubMeet;

WITH ScalarFunctions AS (
    SELECT 
        o.object_id,
        QUOTENAME(OBJECT_SCHEMA_NAME(o.object_id)) + '.' + QUOTENAME(o.name) AS FunctionName
    FROM sys.objects o
    WHERE o.type IN ('FN', 'IF', 'TF') -- Scalar, Inline Table, Table-valued
      AND o.is_ms_shipped = 0
)
, RoleList AS (
    SELECT 'SCM_Administrator' AS RoleName
    UNION ALL SELECT 'SCM_Guest'
    UNION ALL SELECT 'SCM_Marshall'
)
SELECT 
    sf.FunctionName,
    rl.RoleName,
    CASE 
        WHEN perm.permission_name IS NULL THEN 'MISSING'
        ELSE 'OK'
    END AS ExecutePermission
FROM ScalarFunctions sf
CROSS JOIN RoleList rl
LEFT JOIN sys.database_permissions perm
    ON perm.major_id = sf.object_id
    AND perm.class = 1
    AND perm.type = 'EX'
    AND perm.grantee_principal_id = DATABASE_PRINCIPAL_ID(rl.RoleName)
ORDER BY sf.FunctionName, rl.RoleName;