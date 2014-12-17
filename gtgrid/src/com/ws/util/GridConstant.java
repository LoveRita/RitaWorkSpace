package com.ws.util;


/**
 * 项目工程全局常量
 * @author whn
 * @date   2014-03-13
 */
public class GridConstant {
	
	/*
	 * 常量类命名规范：
	 * 1. 每个常量都必须写明注释，阐明含义
	 * 2. 对于数据字典类型，以'TYPE_'开头
	 * 3. 对于数据字典的值，以'VALUE_'开头
	 * 4. 对于功能代码，以'FUNC_'开头
	 */

	/** 客户状态 */
	public static final String TYPE_CUSTOMER_STATUS = "customerStatus";
	/** VIP级别 */
	public static final String TYPE_VIPLEVELs = "vipLevel";
	/** 分公司 */
	public static final String TYPE_BRANCH = "viewBranch";
	/** 行业 */
	public static final String TYPE_INDUSTRY = "industry";

	/** 客户状态-启用 */
	public static final String VALUE_CUST_STATUS_ACTIVE = "1";
	/** 客户状态-挂起 */
	public static final String VALUE_CUST_STATUS_SUSPEND = "0";
	/** 客户状态-锁定 */
	public static final String VALUE_CUST_STATUS_LOCK = "2";

	/** 客户管理功能--增删改 */
	public static final String FUNC_MANAGE_CUST = "manageCustomer";

}
