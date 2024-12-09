#include <os/log.h>
#ifndef Logging_h
#define Logging_h



#    define ELog(N, ...) os_log_with_type(os_log_create("com.messagesplugin.messaging", "DEBUG"),OS_LOG_TYPE_ERROR,N,##__VA_ARGS__)
#    define DLog(N, ...) os_log_with_type(os_log_create("com.messagesplugin.messaging", "DEBUG"),OS_LOG_TYPE_DEFAULT,N ,##__VA_ARGS__)


#endif /* Logging_h */
