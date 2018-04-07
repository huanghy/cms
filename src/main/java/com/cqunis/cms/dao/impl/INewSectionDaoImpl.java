package com.cqunis.cms.dao.impl;

import com.cqunis.cms.dao.INewSectionDaoCustom;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

public class INewSectionDaoImpl
  implements INewSectionDaoCustom
{

  @Autowired
  @PersistenceContext
  private EntityManager entityManager;
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.impl.INewSectionDaoImpl
 * JD-Core Version:    0.6.1
 */