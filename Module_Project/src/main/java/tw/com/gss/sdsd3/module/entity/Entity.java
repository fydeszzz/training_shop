package tw.com.gss.sdsd3.module.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/**
 * ORM POJO。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString
public class Entity<T> implements Serializable {
    private T id;
}
