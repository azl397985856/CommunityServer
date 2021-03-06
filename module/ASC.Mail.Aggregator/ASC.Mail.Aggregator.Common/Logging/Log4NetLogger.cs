/*
 *
 * (c) Copyright Ascensio System Limited 2010-2015
 *
 * This program is freeware. You can redistribute it and/or modify it under the terms of the GNU 
 * General Public License (GPL) version 3 as published by the Free Software Foundation (https://www.gnu.org/copyleft/gpl.html). 
 * In accordance with Section 7(a) of the GNU GPL its Section 15 shall be amended to the effect that 
 * Ascensio System SIA expressly excludes the warranty of non-infringement of any third-party rights.
 *
 * THIS PROGRAM IS DISTRIBUTED WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE. For more details, see GNU GPL at https://www.gnu.org/copyleft/gpl.html
 *
 * You can contact Ascensio System SIA by email at sales@onlyoffice.com
 *
 * The interactive user interfaces in modified source and object code versions of ONLYOFFICE must display 
 * Appropriate Legal Notices, as required under Section 5 of the GNU GPL version 3.
 *
 * Pursuant to Section 7 § 3(b) of the GNU GPL you must retain the original ONLYOFFICE logo which contains 
 * relevant author attributions when distributing the software. If the display of the logo in its graphic 
 * form is not reasonably feasible for technical reasons, you must include the words "Powered by ONLYOFFICE" 
 * in every copy of the program you distribute. 
 * Pursuant to Section 7 § 3(e) we decline to grant you any rights under trademark law for use of our trademarks.
 *
*/


using System;
using System.Linq;
using log4net;
using log4net.Appender;
using log4net.Repository;

namespace ASC.Mail.Aggregator.Common.Logging
{
    public class Log4NetLogger : ILogger
    {
        private readonly ILog _logger;

        public Log4NetLogger(ILog logger)
        {
            _logger = logger;
        }

        public void Fatal(string message, params object[] param)
        {
            var str = String.Format(message, param);
            _logger.Fatal(str);
        }

        public void Fatal(Exception ex, string message, params object[] param)
        {
            var originalMessage = String.Format(message, param);
            _logger.Fatal(originalMessage + " Exception: " + ex);
        }

        public void Error(string message, object[] param)
        {
            var str = String.Format(message, param);
            _logger.Error(str);
        }

        public void Error(Exception ex, string message, params object[] param)
        {
            var originalMessage = String.Format(message, param);
            _logger.Error(originalMessage + " Exception: " + ex);
        }

        public void Warn(string message, object[] param)
        {
            var str = String.Format(message, param);
            _logger.Warn(str);
        }

        public void Debug(string message, object[] param)
        {
            var str = String.Format(message, param);
            _logger.Debug(str);
        }

        public void WarnException(string format, Exception exception)
        {
            _logger.Warn(format, exception);
        }

        public void Info(string message, params object[] param)
        {
            var str = String.Format(message, param);
            _logger.Info(str);
        }

        public void Flush()
        {
            ILoggerRepository rep = LogManager.GetRepository();
            foreach (var buffered in rep.GetAppenders().OfType<BufferingAppenderSkeleton>())
            {
                buffered.Flush();
            }
        }
    }
}
