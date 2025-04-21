import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import javax.sql.DataSource;
import java.sql.Connection;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations ="file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DBTest {

    @Autowired
    private DataSource dataSource;
    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @Test
    @DisplayName("HikariCP 설정 및 DB 연결 테스트")
    public void hikariConnectionTest() throws Exception {
        Connection connection = dataSource.getConnection();
        log.info(connection);
        assertNotNull(connection);
        connection.close();
    }
    
    @Test
    @DisplayName("MyBatis SqlSessionFactory 및 DB 연결 테스트")
    void sqlSessionFactoryLoads() {
        assertNotNull(sqlSessionFactory, "SqlSessionFactory가 로드되어야 합니다");
        try (SqlSession session = sqlSessionFactory.openSession()) {
            assertNotNull(session, "SqlSession이 생성되어야 합니다");
            log.info("opened session: {}", session);
        }
    }
}
