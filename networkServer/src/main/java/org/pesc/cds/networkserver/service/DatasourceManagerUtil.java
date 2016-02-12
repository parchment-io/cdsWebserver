package org.pesc.cds.networkserver.service;

import org.pesc.cds.networkserver.domain.NetworkServerId;
import org.pesc.cds.networkserver.domain.NetworkServerSettings;
import org.pesc.cds.networkserver.domain.TransactionsDao;

public class DatasourceManagerUtil {
	private static NetworkServerId identification;
	private static NetworkServerSettings systemProperties;
	private static TransactionsDao transactions = buildTransactions();
	
	private static TransactionsDao buildTransactions() {
		return new TransactionsDao();
	}
	
	public static NetworkServerId getIdentification() { return identification; }
	public static void setIdentification(NetworkServerId id) { identification = id; }
	public static NetworkServerSettings getSystemProperties() { return systemProperties; }
	public static void setSystemProperties(NetworkServerSettings settings) { systemProperties = settings; }
	public static TransactionsDao getTransactions() { return transactions; }
}
