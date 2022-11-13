/* Row.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.Row : Object {
    public string content { get; set; default= ""; }
    public bool is_number  {
        get {
            return double.try_parse (content);
        }
    }

    public Row (string content) {
        Object (content: content);
    }
}
