package com.cqunis.cms.service;

import com.cqunis.cms.entity.NewSection;
import com.cqunis.entity.Unit;
import com.cqunis.service.support.IBaseService;
import java.util.List;
import java.util.Map;

public abstract interface INewSectionService extends IBaseService<NewSection, String>
{
  public abstract void saveOrUpdate(NewSection paramNewSection);

  public abstract List<Map<String, Object>> getNewSectionTree(String paramString1, List<Unit> paramList, Integer paramInteger, String paramString2);

  public abstract List<NewSection> loadNewSection(String paramString1, Integer paramInteger, String paramString2, String paramString3);
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.INewSectionService
 * JD-Core Version:    0.6.1
 */