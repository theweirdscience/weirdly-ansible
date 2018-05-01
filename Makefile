
splitfiles:
	cd roles/has-kibana/files/ && split -b 49m kibana-6.2.4-linux-x86_64.tar.gz kibana-6.2.4-linux-x86_64.tar.gz.
	cd roles/has-open-am/files/ && split -b 49m AM-eval-5.5.1.war AM-eval-5.5.1.war.

joinfiles:
	cd roles/has-kibana/files/ && cat kibana-6.2.4-linux-x86_64.tar.gz.* > kibana-6.2.4-linux-x86_64.tar.gz
	cd roles/has-open-am/files/ && cat AM-eval-5.5.1.war.* > AM-eval-5.5.1.war