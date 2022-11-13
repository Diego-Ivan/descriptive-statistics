/* StandardDeviation.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.StandardDeviation : Operator {
    public override string name {
        get {
            return "Standard Deviation";
        }
    }

    public StandardDeviation (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        shared_data.std_dev = sqrt (shared_data.variance);
        return shared_data.std_dev;
    }
}
