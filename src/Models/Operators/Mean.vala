/* Mean.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Mean : Operator {
    public override string name {
        get {
            return "Mean";
        }
    }

    public Mean (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        shared_data.mean = shared_data.sum / shared_data.count;
        return shared_data.mean;
    }
}
