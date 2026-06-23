package cn.edu.training.kingbaseasset.repository;

import cn.edu.training.kingbaseasset.model.Asset;
import cn.edu.training.kingbaseasset.model.AssetForm;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Repository
public class AssetRepository {
    private final JdbcTemplate jdbcTemplate;

    public AssetRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Asset> findAll(String keyword, Long categoryId, String status) {
        StringBuilder sql = new StringBuilder("""
                SELECT a.id, a.asset_code, a.asset_name, a.category_id, c.name AS category_name,
                       a.department_id, d.name AS department_name, a.supplier_id, s.name AS supplier_name,
                       a.purchase_date, a.original_value, a.status, a.keeper, a.remark,
                       a.created_at, a.updated_at
                  FROM kb_asset a
                  JOIN kb_asset_category c ON c.id = a.category_id
                  JOIN kb_department d ON d.id = a.department_id
                  JOIN kb_supplier s ON s.id = a.supplier_id
                 WHERE 1 = 1
                """);
        if (StringUtils.hasText(keyword)) {
            String pattern = escapeSqlLike(keyword.trim().toLowerCase());
            sql.append("""
                     AND (LOWER(a.asset_code) LIKE '%s'
                          OR LOWER(a.asset_name) LIKE '%s'
                          OR LOWER(d.name) LIKE '%s'
                          OR LOWER(a.keeper) LIKE '%s')
                    """.formatted(pattern, pattern, pattern, pattern));
        }
        if (categoryId != null) {
            sql.append(" AND a.category_id = ").append(categoryId);
        }
        if (StringUtils.hasText(status)) {
            sql.append(" AND a.status = ").append(sqlStringLiteral(status.trim()));
        }

        sql.append(" ORDER BY a.updated_at DESC, a.id DESC");
        return jdbcTemplate.query(sql.toString(), assetMapper());
    }

    public Optional<Asset> findById(Long id) {
        List<Asset> assets = jdbcTemplate.query("""
                SELECT a.id, a.asset_code, a.asset_name, a.category_id, c.name AS category_name,
                       a.department_id, d.name AS department_name, a.supplier_id, s.name AS supplier_name,
                       a.purchase_date, a.original_value, a.status, a.keeper, a.remark,
                       a.created_at, a.updated_at
                  FROM kb_asset a
                  JOIN kb_asset_category c ON c.id = a.category_id
                  JOIN kb_department d ON d.id = a.department_id
                  JOIN kb_supplier s ON s.id = a.supplier_id
                 WHERE a.id = %d
                """.formatted(id), assetMapper());
        return assets.stream().findFirst();
    }

    public void create(AssetForm form) {
        jdbcTemplate.execute("""
                INSERT INTO kb_asset (
                    asset_code, asset_name, category_id, department_id, supplier_id,
                    purchase_date, original_value, status, keeper, remark,
                    created_at, updated_at
                )
                VALUES (%s, %s, %d, %d, %d, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """.formatted(
                sqlStringLiteral(trim(form.getAssetCode())),
                sqlStringLiteral(trim(form.getAssetName())),
                form.getCategoryId(),
                form.getDepartmentId(),
                form.getSupplierId(),
                sqlDateLiteral(form.getPurchaseDate()),
                sqlDecimalLiteral(form.getOriginalValue()),
                sqlStringLiteral(form.getStatus()),
                sqlStringLiteral(trim(form.getKeeper())),
                sqlStringLiteral(trim(form.getRemark()))
        ));
    }

    public void update(Long id, AssetForm form) {
        jdbcTemplate.execute("""
                UPDATE kb_asset
                   SET asset_code = %s,
                       asset_name = %s,
                       category_id = %d,
                       department_id = %d,
                       supplier_id = %d,
                       purchase_date = %s,
                       original_value = %s,
                       status = %s,
                       keeper = %s,
                       remark = %s,
                       updated_at = CURRENT_TIMESTAMP
                 WHERE id = %d
                """.formatted(
                sqlStringLiteral(trim(form.getAssetCode())),
                sqlStringLiteral(trim(form.getAssetName())),
                form.getCategoryId(),
                form.getDepartmentId(),
                form.getSupplierId(),
                sqlDateLiteral(form.getPurchaseDate()),
                sqlDecimalLiteral(form.getOriginalValue()),
                sqlStringLiteral(form.getStatus()),
                sqlStringLiteral(trim(form.getKeeper())),
                sqlStringLiteral(trim(form.getRemark())),
                id
        ));
    }

    public void delete(Long id) {
        jdbcTemplate.execute("DELETE FROM kb_asset WHERE id = " + id);
    }

    private RowMapper<Asset> assetMapper() {
        return new RowMapper<>() {
            @Override
            public Asset mapRow(ResultSet rs, int rowNum) throws SQLException {
                Asset asset = new Asset();
                asset.setId(rs.getLong("id"));
                asset.setAssetCode(rs.getString("asset_code"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setCategoryId(rs.getLong("category_id"));
                asset.setCategoryName(rs.getString("category_name"));
                asset.setDepartmentId(rs.getLong("department_id"));
                asset.setDepartmentName(rs.getString("department_name"));
                asset.setSupplierId(rs.getLong("supplier_id"));
                asset.setSupplierName(rs.getString("supplier_name"));
                asset.setPurchaseDate(toLocalDate(rs.getDate("purchase_date")));
                asset.setOriginalValue(rs.getBigDecimal("original_value"));
                asset.setStatus(rs.getString("status"));
                asset.setKeeper(rs.getString("keeper"));
                asset.setRemark(rs.getString("remark"));
                asset.setCreatedAt(toLocalDateTime(rs.getTimestamp("created_at")));
                asset.setUpdatedAt(toLocalDateTime(rs.getTimestamp("updated_at")));
                return asset;
            }
        };
    }

    private java.time.LocalDateTime toLocalDateTime(Timestamp value) {
        return value == null ? null : value.toLocalDateTime();
    }

    private java.time.LocalDate toLocalDate(Date value) {
        return value == null ? null : value.toLocalDate();
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String sqlStringLiteral(String value) {
        if (value == null) {
            return "NULL";
        }
        return "'" + value.replace("'", "''") + "'";
    }

    private String escapeSqlLike(String value) {
        return "%" + value.replace("'", "''") + "%";
    }

    private String sqlDateLiteral(java.time.LocalDate value) {
        return value == null ? "NULL" : "'" + value + "'";
    }

    private String sqlDecimalLiteral(java.math.BigDecimal value) {
        return value == null ? "NULL" : value.toPlainString();
    }
}
