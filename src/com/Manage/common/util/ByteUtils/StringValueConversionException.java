/*
 * $Id: StringValueConversionException.java,v 1.4 2005/01/15 19:24:06
 * jonathanlocke Exp $ $Revision$ $Date$
 *
 * ==============================================================================
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
//package wicket.util.string;
package com.Manage.common.util.ByteUtils;

/**
 * Thrown when a string value cannot be converted to some type.
 *
 * @author Jonathan Locke
 */
public final class StringValueConversionException extends Exception
{
	/**
	 * Constructor.
	 *
	 * @param message
	 *            exception message
	 */
	public StringValueConversionException(final String message)
	{
		super(message);
	}

	/**
	 * Constructor.
	 *
	 * @param message
	 *            exception message
	 * @param cause
	 *            exception cause
	 */
	public StringValueConversionException(final String message, final Throwable cause)
	{
		super(message, cause);
	}
}
